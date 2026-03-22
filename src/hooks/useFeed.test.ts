import { renderHook, waitFor } from '@testing-library/react'
import { useFeed } from './useFeed'

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
