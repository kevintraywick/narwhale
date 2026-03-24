export interface PendingDrop {
  title?: string
  link?: string
  file?: File
}

let _pending: PendingDrop | null = null
export function setPending(p: PendingDrop) { _pending = p }
export function getPending(): PendingDrop | null { return _pending }
export function clearPending() { _pending = null }
