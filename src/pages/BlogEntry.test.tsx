import { render, screen, waitFor } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import BlogEntry from './BlogEntry'

beforeEach(() => {
  vi.stubGlobal('fetch', vi.fn().mockResolvedValue({
    ok: true,
    json: async () => ({
      id: 1,
      title: 'Hello world',
      note: 'Full note text.',
      link: null,
      created_at: '2026-03-20T00:00:00',
      comments: [{ id: 1, entry_id: 1, body: 'Nice!', created_at: '2026-03-21T00:00:00' }]
    })
  }))
})

afterEach(() => vi.unstubAllGlobals())

test('renders entry title and note', async () => {
  render(
    <MemoryRouter initialEntries={['/blog/1']}>
      <Routes><Route path="/blog/:id" element={<BlogEntry />} /></Routes>
    </MemoryRouter>
  )
  await waitFor(() => expect(screen.getByText('Hello world')).toBeInTheDocument())
  expect(screen.getByText('Full note text.')).toBeInTheDocument()
})

test('renders comments', async () => {
  render(
    <MemoryRouter initialEntries={['/blog/1']}>
      <Routes><Route path="/blog/:id" element={<BlogEntry />} /></Routes>
    </MemoryRouter>
  )
  await waitFor(() => expect(screen.getByText('Nice!')).toBeInTheDocument())
})

test('renders image when entry has image_url', async () => {
  vi.stubGlobal('fetch', vi.fn().mockResolvedValue({
    ok: true,
    json: async () => ({
      id: 1,
      title: 'Photo post',
      note: null,
      link: null,
      image_url: 'https://cdn.example.com/img.jpg',
      created_at: '2026-03-20T00:00:00',
      comments: [],
    }),
  }))

  const { container } = render(
    <MemoryRouter initialEntries={['/blog/1']}>
      <Routes><Route path="/blog/:id" element={<BlogEntry />} /></Routes>
    </MemoryRouter>
  )
  await waitFor(() => expect(screen.getByText('Photo post')).toBeInTheDocument())
  const img = container.querySelector('img')
  expect(img).not.toBeNull()
  expect(img!.src).toContain('cdn.example.com/img.jpg')
})

test('does not render image when entry has no image_url', async () => {
  const { container } = render(
    <MemoryRouter initialEntries={['/blog/1']}>
      <Routes><Route path="/blog/:id" element={<BlogEntry />} /></Routes>
    </MemoryRouter>
  )
  await waitFor(() => expect(screen.getByText('Hello world')).toBeInTheDocument())
  expect(container.querySelector('img')).toBeNull()
})
