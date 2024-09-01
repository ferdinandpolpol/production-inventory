'use client'; // Ensure this is treated as a Client Component

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Form as LoginForm } from '../components/loginForm';
import { Main } from './main';

const App = () => {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null);
  const router = useRouter();

  useEffect(() => {
    const user = localStorage.getItem('user');
    if (user) {
      const { access } = JSON.parse(user);
      if (access) {
        setIsAuthenticated(true);
      } else {
        setIsAuthenticated(false);
      }
    } else {
      setIsAuthenticated(false);
    }
  }, []);

  if (isAuthenticated === null) {
    return <div>Loading...</div>;
  }

  return isAuthenticated ? <Main /> : <LoginForm />;
};

export default App;
