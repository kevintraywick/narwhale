import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import Blog from './Blog'

vi.mock('../hooks/useFeed', () => ({
  useFeed: () => ({
    entries: [
      { id: 1, title: 'First post', note: 'Full note text here', created_at: '2026-03-20T00:00:00', comment_count: 2 },
      { id: 2, title: 'Second post', note: null, created_at: '2026-03-18T00:00:00', comment_count: 0 },
    ],
    loading: false,
    postComment: vi.fn(),
  }),
}))

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
