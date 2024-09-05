"use client";

import { useEffect, useState } from "react";
import { TrashIcon, ResetIcon } from "@radix-ui/react-icons";
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
import { SelectVendorForm } from "./components/selectVendorForm";
import { SupplyForm, PurchaseRecord } from "./components/supplyForm";

interface SupplierData {
  selectedSupplier: any;
  purchaseAmount: number;
  purchaseNotes: string;
  supplyDate: string;
}

export default function PurchasePage() {
  const [supplyItems, setSupplyItems] = useState([]);
  const [suppliers, setSuppliers] = useState([]);
  const [_supplierData, setSupplierData] = useState({} as SupplierData);

  useEffect(() => {
    async function getSupplyItems() {
      try {
        const response = await request("/supply_item/");
        setSupplyItems(response);
      } catch (error) {
        console.error(error);
      }
    }

    async function getSuppliers() {
      try {
        const response = await request("/supplier/");
        setSuppliers(response);
      } catch (error) {
        console.error(error);
      }
    }

    getSuppliers();
    getSupplyItems();
  }, []);

  const finalizePurchase = (purchaseRecords: PurchaseRecord[]) => {
    console.log("Finalize purchase");

    if (!_supplierData.selectedSupplier) {
      console.error("No supplier selected");
      return
    }
    
    try {
      request("/purchase/", {
        method: "POST",
        body: JSON.stringify({
          supplies: purchaseRecords.map((record) => ({
            quantity: record.quantity,
            supplied_at: _supplierData.supplyDate,
            item: record.item,
          })),
          type: "SUPPLY",
          amount: 0,
          notes: _supplierData.purchaseNotes,
          date: _supplierData.supplyDate,
          supplier: _supplierData.selectedSupplier.id,
        }),
      });
    } catch (error) {
      console.error(error);
    }
  };

  const supplierData = (data: any) => {
    setSupplierData(data);
  }

  return (
    <div className="mt-20 mt-10 w-[90vw] h-[90vw]">
      <div className="flex justify-between flex-row">
        <div className="w-full p-4">
          <SelectVendorForm suppliers={suppliers} supplierData={supplierData} />
        </div>

        <div className="w-full p-4">
          <SupplyForm
            supplyItems={supplyItems}
            finalizePurchase={finalizePurchase}
          />
        </div>
      </div>
    </div>
  );
}
