"use client";

import { useEffect, useState } from "react";
import { TrashIcon, ResetIcon } from "@radix-ui/react-icons";
import { SelectCustomerForm } from "./components/selectCustomerForm";
import { AddSaleForm } from "./components/addSaleForm";

import { request } from "@/utils/request";

import { Button } from "@/components/ui/button";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

interface SalesData {
  productId: string;
  product: string;
  quantity: number;
  freebies: number;
  sales: number;
}

export default function SalesPage() {
  const [customers, setCustomers] = useState([]);
  const [products, setProducts] = useState([]);
  const [showSaleForm, setShowSaleForm] = useState(false);
  const [salesData, setSalesData] = useState<SalesData[]>([]);
  const [_saleInitialData, setSaleInitialData] = useState<any>(null);  

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

    setSalesData(JSON.parse(localStorage.getItem("salesData") || "[]"));

    getCustomers();
    getProducts();
  }, []);

  useEffect(() => {
    localStorage.setItem("salesData", JSON.stringify(salesData));
  }, [salesData]);

  const saleInitialData = (data: any) => {
    setShowSaleForm(true);
    setSaleInitialData(data);
  };

  const addSaleData = (data: SalesData) => {
    if (salesData.some((sale) => sale.product === data.product)) {
      alert(`Product ${data.product} already added`);
      return;
    }
    setSalesData((prevData: SalesData[]) => [data, ...prevData]);
  };

  const deleteItem = (index: number) => {
    const newData = salesData.filter((_, i) => i !== index);
    setSalesData(newData);
  }

  const resetSales = () => {
    // confirm reset
    if (!confirm("Are you sure you want to reset sales?")) {
      return;
    }

    setSalesData([]);
  }

  const finalizeSale = async () => {  
    // customer, date, salesData length validation
    if (!_saleInitialData || !salesData.length) {
      alert("Please select a customer and add sales data");
      return
    }
    
    const data = salesData.map((sale) => {
      return {
        sales_type: _saleInitialData.salesType,
        customer: _saleInitialData.customerId,
        date: _saleInitialData.date,
        product: sale.productId,
        quantity: sale.quantity,
        freebies: sale.freebies,
        actual_sale: sale.sales,
      };
    })

    try {
      const response = await request("/sales/", {
        method: "POST",
        body: JSON.stringify(data),
      });

      if (response.ok) {
        alert(`Sales for customer ${_saleInitialData.customer} has been finalized`);
        setSalesData([]);
      }
    } catch (error) {
      console.error(error);
    }

  };

  return (
    <div className="mt-20 mt-10 w-[90vw] h-[90vw]">
      <div className="flex flex-row max-sm:flex-col">
        <div className="w-full p-4">
          <SelectCustomerForm
            customers={customers}
            saleInitialData={saleInitialData}
          />
        </div>

        <div className="w-full p-4">
          <AddSaleForm products={products} addSaleData={addSaleData} />
        </div>
      </div>
      {salesData.length > 0 ? (
        <div className="flex flex-col bg-slate-100 m-4 rounded">
          <div>
            <h1 className="w-full p-4 text-lg font-bold">Sales Summary</h1>
          </div>

          <div className="flex flex-row justify-start p-4">

            <div className="w-full p-4">
              <Button 
                className="bg-rose-500 hover:bg-rose-800 sticky bottom-0"
                onClick={(e) => resetSales()}
              >
                <ResetIcon className="h-4 w-4" />
              </Button>
            </div>

            <div className="w-full p-4">
              <Button 
                className="w-full bg-rose-500 hover:bg-rose-800 sticky bottom-0"
                onClick={() => finalizeSale()}
              >Finalize Sale</Button>
            </div>
          </div>
          <div className="w-full p-4">
            <Table className=" overflow-y-auto table w-full bg-slate-100 rounded p-10">
              <TableHeader className="sticky top-0 bg-secondary">
                <TableRow>
                  <TableHead>Product</TableHead>
                  <TableHead>Quantity</TableHead>
                  <TableHead>Freebies</TableHead>
                  <TableHead>Sales</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {salesData.map((sale, index) => (
                  <TableRow key={index}>
                    <TableCell>{sale.product}</TableCell>
                    <TableCell>{sale.quantity}</TableCell>
                    <TableCell>{sale.freebies}</TableCell>
                    <TableCell>₱ {sale.sales}</TableCell>
                    <TableCell>
                      <Button 
                      variant="secondary" 
                      className="border"
                      onClick={(e) => { deleteItem(index) } }
                      >
                        <TrashIcon className="h-4 w-4" />  
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}

                {salesData.length > 0 ? (
                  salesData.reduce((acc, sale) => acc + sale.sales, 0) > 0 ? (
                    <TableRow>
                      <TableCell>Total</TableCell>
                      <TableCell></TableCell>
                      <TableCell></TableCell>
                      <TableCell>₱ {salesData.reduce((acc, sale) => acc + sale.sales, 0)}</TableCell>
                    </TableRow>
                  ) : null
                ) : null}
              </TableBody>
            </Table>
          </div>

        </div>
      ) : null}
    </div>
  );
}
