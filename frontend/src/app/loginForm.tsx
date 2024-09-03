'use client'

import { Alert } from '@/components/ui/alert'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { useState } from 'react'

export const Form = () => {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    console.log("Test Login")

    await fetch('/api/token', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    })
    .then((res) => res.json())
    .then((data) => {
      if (data.error) {
        setError(data.error)
      } else {
        localStorage.setItem('user', JSON.stringify(data))
        window.location.href = '/'
      }
    })
  }

  return (
    <form onSubmit={onSubmit} className="space-y-8 w-full sm:w-[400px]">
      <div className="grid w-full items-center gap-1">
        <Label htmlFor="email">Username</Label>
        <Input
          className="w-full"
          required
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          id="email"
          type="email"
        />
      </div>
      <div className="grid w-full items-center gap-1">
        <Label htmlFor="password">Password</Label>
        <Input
          className="w-full"
          required
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          id="password"
          type="password"
        />
      </div>
      {error && <Alert>{error}</Alert>}
      <div className="w-full">
        <Button className="w-full bg-rose-500 hover:bg-rose-800 text-white" size="lg">
          Login
        </Button>
      </div>
    </form>
  )
}
