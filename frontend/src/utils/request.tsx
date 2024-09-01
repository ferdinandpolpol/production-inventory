'use client'

import { API_URL } from "@/constants";

// Function to get the access token only on the client side
const getAccessToken = () => {
  if (typeof window !== "undefined") {
    const user = localStorage?.getItem("user");
    if (user) {
      const parsedUser = JSON.parse(user);
      return parsedUser?.access;
    }
  }
  return null;
};

const refreshToken = async (token: string) => {
  const response = await fetch(`${API_URL}/token/refresh/`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ refresh: refreshToken }),
  });

  if (response.ok) {
    const data = await response.json();
    if (typeof window !== "undefined") {
      localStorage?.setItem("user", JSON.stringify(data));
    }
    return data.access;
  } else {
    throw new Error("Refresh token is invalid or expired.");
  }
};

export const request = async (url: string, options: RequestInit = {}) => {
  const headers = new Headers(options.headers);

  // Get access token only on the client side
  let _accessToken: string | null = null;
  let _refreshToken: string | null = null;
  
  if (typeof window !== "undefined") {
    _accessToken = getAccessToken();
    _refreshToken = _accessToken
      ? JSON.parse(localStorage.getItem("user") || "{}")?.refresh
      : null;
  }

  if (_accessToken) {
    headers.set("Authorization", `Bearer ${_accessToken}`);
  }

  headers.set("Content-Type", "application/json");

  try {
    console.log("Requesting:", `${API_URL}${url}`);
    let response = await fetch(`${API_URL}${url}`, {
      ...options,
      headers,
    });

    if (response.status === 401 && _refreshToken) {
      const newAccessToken = await refreshToken(_refreshToken);
      headers.set("Authorization", `Bearer ${newAccessToken}`);

      response = await fetch(`${API_URL}${url}`, { ...options, headers });

      if (!response.ok) {
        throw new Error(
          `Request failed after token refresh: ${response.statusText}`,
        );
      }
    }

    if (!response.ok) {
      throw new Error(`Request failed: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error("Request error:", error);
    throw error;
  }
};
