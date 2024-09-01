import Link from 'next/link'
import { Form as LoginForm } from './loginForm'
import { Navbar as Header } from './header'
import React, { useEffect } from 'react'

export default function LoginPage() {
  const isAuthenticated = false

  return (
    <div className="h-screen w-screen flex justify-center items-center bg-gradient-to-r from-rose-800 to-rose-500">
      {isAuthenticated ? (
        <div>
          Test
        </div>
      ) : (
        <div className="sm:shadow-xl px-10 py-10 sm:bg-slate-50 rounded-xl space-y-12">
          <h1 className="font-semibold text-2xl">Login</h1>
          <LoginForm />
        </div>
      )}
    </div>
  ) 
}
