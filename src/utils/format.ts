export function formatDate(iso: string, includeYear = false) {
  return new Date(iso).toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    ...(includeYear ? { year: 'numeric' } : {}),
  })
}

export function hostname(url: string) {
  try { return new URL(url).hostname } catch { return url }
}
