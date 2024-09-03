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
import { SupplyForm } from "./components/supplyForm";

export default function PurchasePage() {
  const [supplyItems, setSupplyItems] = useState([]);
  const [suppliers, setSuppliers] = useState([]);
  const [purchaseRecords, setPurchaseRecords] = useState([]);

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

  const finalizePurchase = () => {
    console.log("Purchase finalized");
  };

  return (
    <div className="mt-20 mt-10 w-[90vw] h-[90vw]">
      <div className="flex justify-between flex-row">
        <div className="w-full p-4">
          <SelectVendorForm suppliers={suppliers} />
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
