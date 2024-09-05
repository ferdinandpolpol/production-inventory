"use client";

import Link from "next/link";
import React, { useEffect, useState } from "react";
import { FaBars, FaTimes } from "react-icons/fa";

export const LogOut = (e: React.MouseEvent<HTMLAnchorElement>) => {
  e.preventDefault();
  if (typeof window !== "undefined") localStorage.removeItem("user");
  window.location.href = "/";
};

export const Navbar = () => {
  const [nav, setNav] = useState(false);

  const [links, setLinks] = useState([
    {
      id: 1,
      link: "production",
    },
    {
      id: 2,
      link: "sales",
    },
    {
      id: 3,
      link: "purchase",
    },
    {
      id: 5,
      link: "reports",
    },
  ]);

  useEffect(() => {
    const user = localStorage.getItem("user");
    if (user) {
      const parsedUser = JSON.parse(user);
      if (parsedUser) {
        setLinks([
          ...links,
          {
            id: 6,
            link: "logout",
          },
        ]);
      }
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="flex justify-between items-center w-full h-15 px-4 text-white bg-transparent fixed nav z-50">
      <div>
        <h1 className="text-6xl font-signature ml-2 text-white-600 text-bold">
          Amoren&apos;s
        </h1>
      </div>

      <ul className="hidden md:flex">
        {links.map(({ id, link }) => (
          <li
            key={id}
            className="nav-links px-4 cursor-pointer capitalize font-medium text-white-500 hover:scale-105 hover:text-rose-500 duration-200 link-underline"
          >
            {link === "logout" ? (
              <a onClick={LogOut} href="/">
                {link}
              </a>
            ) : (
              <Link href={link}>{link}</Link>
            )}
          </li>
        ))}
      </ul>

      <div
        onClick={() => setNav(!nav)}
        className="cursor-pointer pr-4 z-10 text-gray-500 md:hidden"
      >
        {nav ? <FaTimes size={30} /> : <FaBars size={30} />}
      </div>

      {nav && (
        <ul className="flex flex-col justify-center items-center absolute top-0 left-0 w-full h-screen bg-gradient-to-b from-black to-gray-800 text-gray-500">
          {links.map(({ id, link }) => (
            <li
              key={id}
              className="px-4 cursor-pointer capitalize py-6 text-4xl"
            >
              {link === "logout" ? (
                <a onClick={LogOut} href="/">
                  {link}
                </a>
              ) : (
                <Link onClick={() => setNav(!nav)} href={link}>
                  {link}
                </Link>
              )}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};
