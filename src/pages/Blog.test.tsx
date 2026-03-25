import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import Blog from './Blog'

const mockPostEntry = vi.fn()

vi.mock('../hooks/useFeed', () => ({
  useFeed: () => ({
    entries: [
      { id: 1, title: 'First post', note: 'Full note text here', created_at: '2026-03-20T00:00:00', comment_count: 2 },
      { id: 2, title: 'Second post', note: null, created_at: '2026-03-18T00:00:00', comment_count: 0 },
    ],
    loading: false,
    postEntry: mockPostEntry,
    postComment: vi.fn(),
  }),
  API_URL: '',
}))

beforeEach(() => {
  mockPostEntry.mockClear()
  mockPostEntry.mockResolvedValue({ id: 99, title: 'x', created_at: '2026-03-24', comment_count: 0 })
})

test('renders blog header', () => {
  render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(screen.getByText(/Kevin Traywick/i)).toBeInTheDocument()
})

test('renders entry titles', () => {
  render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(screen.getByText('First post')).toBeInTheDocument()
  expect(screen.getByText('Second post')).toBeInTheDocument()
})

test('renders comment count', () => {
  render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(screen.getByText('2 comments')).toBeInTheDocument()
})

// --- Image preview tests ---

test('shows image preview and pre-fills title when imageUrl is in Router state', () => {
  render(
    <MemoryRouter initialEntries={[{ pathname: '/blog', state: { imageUrl: 'https://cdn.example.com/img.jpg', title: 'photo.jpg' } }]}>
      <Blog />
    </MemoryRouter>
  )
  const img = screen.getByRole('presentation') as HTMLImageElement
  expect(img.src).toContain('cdn.example.com/img.jpg')
  expect((screen.getByPlaceholderText('Title…') as HTMLInputElement).value).toBe('photo.jpg')
})

test('no image preview when Router state has no imageUrl', () => {
  const { container } = render(<MemoryRouter><Blog /></MemoryRouter>)
  expect(container.querySelectorAll('img')).toHaveLength(0)
  expect(screen.queryByText('✕')).not.toBeInTheDocument()
})

test('remove button clears image preview', () => {
  const { container } = render(
    <MemoryRouter initialEntries={[{ pathname: '/blog', state: { imageUrl: 'https://cdn.example.com/img.jpg' } }]}>
      <Blog />
    </MemoryRouter>
  )
  expect(container.querySelectorAll('img')).toHaveLength(1)
  fireEvent.click(screen.getByText('✕'))
  expect(container.querySelectorAll('img')).toHaveLength(0)
})

test('postEntry is called with imageUrl when preview is active', async () => {
  render(
    <MemoryRouter initialEntries={[{ pathname: '/blog', state: { imageUrl: 'https://cdn.example.com/img.jpg', title: 'photo.jpg' } }]}>
      <Blog />
    </MemoryRouter>
  )
  fireEvent.click(screen.getByText('Post'))
  await waitFor(() => expect(mockPostEntry).toHaveBeenCalledWith(
    'photo.jpg', '', '', 'https://cdn.example.com/img.jpg'
  ))
})

test('postEntry is called without imageUrl after preview is removed', async () => {
  render(
    <MemoryRouter initialEntries={[{ pathname: '/blog', state: { imageUrl: 'https://cdn.example.com/img.jpg', title: 'photo.jpg' } }]}>
      <Blog />
    </MemoryRouter>
  )
  fireEvent.click(screen.getByText('✕'))
  fireEvent.click(screen.getByText('Post'))
  await waitFor(() => expect(mockPostEntry).toHaveBeenCalledWith(
    'photo.jpg', '', '', undefined
  ))
})
