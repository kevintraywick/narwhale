import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { FeedOverlay } from './FeedOverlay'

vi.mock('../hooks/useFeed', () => ({
  useFeed: () => ({
    entries: [
      { id: 1, title: 'Test entry', note: 'A note here', created_at: '2026-03-20T00:00:00', comment_count: 0 },
    ],
    loading: false,
    postEntry: vi.fn(),
    postComment: vi.fn(),
  }),
}))

test('renders entry title', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByText('Test entry')).toBeInTheDocument()
})

test('renders entry note preview', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByText('A note here')).toBeInTheDocument()
})

test('renders comment input for each entry', () => {
  render(<MemoryRouter><FeedOverlay /></MemoryRouter>)
  expect(screen.getByPlaceholderText('Add a comment…')).toBeInTheDocument()
})

