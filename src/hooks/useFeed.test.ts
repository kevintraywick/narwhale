import { renderHook, waitFor, act } from '@testing-library/react'
import { useFeed, uploadImage } from './useFeed'

beforeEach(() => {
  vi.stubGlobal('fetch', vi.fn())
})

afterEach(() => {
  vi.unstubAllGlobals()
})

test('loads entries on mount', async () => {
  vi.mocked(fetch).mockResolvedValueOnce({
    ok: true,
    json: async () => [{ id: 1, title: 'Hello', comment_count: 0, created_at: '2026-03-20' }]
  } as Response)

  const { result } = renderHook(() => useFeed())
  await waitFor(() => expect(result.current.loading).toBe(false))
  expect(result.current.entries).toHaveLength(1)
  expect(result.current.entries[0].title).toBe('Hello')
})

test('handles fetch failure gracefully — returns empty entries', async () => {
  vi.mocked(fetch).mockRejectedValueOnce(new Error('Network error'))
  const { result } = renderHook(() => useFeed())
  await waitFor(() => expect(result.current.loading).toBe(false))
  expect(result.current.entries).toHaveLength(0)
})

test('uploadImage POSTs FormData with auth header and returns url', async () => {
  vi.mocked(fetch).mockResolvedValueOnce({
    ok: true,
    json: async () => ({ url: 'https://cdn.example.com/img.jpg' }),
  } as Response)

  const file = new File(['data'], 'photo.jpg', { type: 'image/jpeg' })
  const url = await uploadImage(file)

  expect(url).toBe('https://cdn.example.com/img.jpg')
  const [calledUrl, options] = vi.mocked(fetch).mock.calls[0] as [string, RequestInit]
  expect(calledUrl).toContain('/uploads')
  expect((options.headers as Record<string, string>)['Authorization']).toMatch(/^Bearer /)
  expect(options.body).toBeInstanceOf(FormData)
})

test('uploadImage rejects when response is not ok', async () => {
  vi.mocked(fetch).mockResolvedValueOnce({ ok: false } as Response)
  const file = new File(['data'], 'photo.jpg', { type: 'image/jpeg' })
  await expect(uploadImage(file)).rejects.toThrow('Upload failed')
})

test('postEntry includes image_url in body when provided', async () => {
  // mock the initial entries fetch then the post
  vi.mocked(fetch)
    .mockResolvedValueOnce({ ok: true, json: async () => [] } as Response)
    .mockResolvedValueOnce({
      ok: true,
      json: async () => ({ id: 2, title: 'pic', created_at: '2026-03-24', comment_count: 0 }),
    } as Response)

  const { result } = renderHook(() => useFeed())
  await waitFor(() => expect(result.current.loading).toBe(false))
  await act(() => result.current.postEntry('pic', '', '', 'https://cdn.example.com/img.jpg'))

  const postCall = vi.mocked(fetch).mock.calls[1]
  const body = JSON.parse(postCall[1]!.body as string)
  expect(body.image_url).toBe('https://cdn.example.com/img.jpg')
})

test('postEntry omits image_url key when not provided', async () => {
  vi.mocked(fetch)
    .mockResolvedValueOnce({ ok: true, json: async () => [] } as Response)
    .mockResolvedValueOnce({
      ok: true,
      json: async () => ({ id: 3, title: 'no pic', created_at: '2026-03-24', comment_count: 0 }),
    } as Response)

  const { result } = renderHook(() => useFeed())
  await waitFor(() => expect(result.current.loading).toBe(false))
  await act(() => result.current.postEntry('no pic'))

  const postCall = vi.mocked(fetch).mock.calls[1]
  const body = JSON.parse(postCall[1]!.body as string)
  expect(body).not.toHaveProperty('image_url')
})
