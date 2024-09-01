"use client"

import { useEffect, useState } from "react";
import { SelectCustomerForm } from "./components/selectCustomerForm";
import { AddSaleForm } from "./components/addSaleForm";

import { request } from "@/utils/request";

export default function SalesPage() {
  const [customers, setCustomers] = useState([]);
  const [products, setProducts] = useState([]);
  const [showSaleForm, setShowSaleForm] = useState(false);  
  const [salesData, setSalesData] = useState([]);

  useEffect(() => {
    async function getCustomers() {
      try {
        const response = await request("/customer/");
        
        setCustomers(response);
      } catch (error) {
        console.error(error);
      }
    }

    async function getProducts() {
      try {
        const response = await request("/product/");

        setProducts(response);
      } catch (error) {
        console.error(error);
      }
    }
    getCustomers();
    getProducts();
  }, []);

  const saleInitialData = (data) => {
    console.log(data);
    setShowSaleForm(true);
  }

  const addSaleData = (data) => {
    setSalesData((prevData) => [data, ...prevData]);
    console.log(salesData);
  }


  return (
    <div>
      <div className="flex flex-row sm:flex-column">
        <div className="w-full p-4">
          <SelectCustomerForm customers={ customers } saleInitialData={ saleInitialData } />
        </div>

        { showSaleForm ? 
          <div className="w-full p-4">
            <AddSaleForm products={ products } addSaleData={ addSaleData } />
          </div>
          : null
        }
      </div>

      <div className="flex flex-row">
        <div className="w-full p-4">
          <table className="table w-full bg-slate-100 rounded p-10">
            <thead>
              <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Freebies</th>
                <th>Sales</th>
              </tr>
            </thead>
            <tbody>
              { salesData.map((sale, index) => (
                <tr key={index}>
                  <td>{ sale.product }</td>
                  <td>{ sale.quantity }</td>
                  <td>{ sale.freebies }</td>
                  <td>{ sale.sales }</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
