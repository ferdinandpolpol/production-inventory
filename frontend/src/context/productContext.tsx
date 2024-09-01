import React, { createContext, useContext, useEffect, useState } from 'react';

interface Product {
  id: number;
  name: string;
  price: number;
  unit: string;
}

interface ProductContextProps {
  products: Product[];
  loading: boolean;
}

const ProductContext = createContext<ProductContextProps | undefined>(undefined);

export const useProductContext = () => {
  const context = useContext(ProductContext);
  if (!context) {
    throw new Error("useProductContext must be used within a ProductProvider");
  }
  return context;
};

export const ProductProvider = ({ children }: { children: React.ReactNode }) => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch data from Django API
    const fetchProducts = async () => {
      try {
        const response = await fetch('/api/products/'); // Adjust the URL to your Django API
        const data = await response.json();
        setProducts(data);
      } catch (error) {
        console.error('Failed to fetch products:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  return (
    <ProductContext.Provider value={{ products, loading }}>
      {children}
    </ProductContext.Provider>
  );
};
