"use client";

import { useState } from "react";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { PlusCircledIcon } from "@radix-ui/react-icons";

interface SupplyItem {
  id: string;
  name: string;
  price: number;
  unit: string;
}

interface SupplyItemsProps {
  supplyItems: SupplyItem[];
  finalizePurchase: () => void;
}

interface PurchaseRecord {
  id: number;
  quantity: number;
  item: string;
}

export const SupplyForm = ({
  supplyItems,
  finalizePurchase,
}: SupplyItemsProps) => {
  console.log(supplyItems);
  const [purchases, setPurchases] = useState([]);
  const [submitPurchase, setSubmitPurchase] = useState(false);

  const addNewPurchase = () => {
    setPurchases([...purchases, { id: Date.now(), quantity: 1, item: "" }]);
  };

  return (
    <div className="bg-slate-100 h-25px max-h-[90vh] rounded p-4 overflow-y-auto">
      <h3>Purchase List</h3>

      <div className="flex flex-row">
        <Button
          className="flex-none w-20 mt-4 items-center border border-black"
          onClick={addNewPurchase}
          variant="secondary"
        >
          Add
          <PlusCircledIcon className="h-4 w-4 ml-2" />
        </Button>
        <div className="flex-1 w-72" />
        {purchases.length > 0 ? (
          <Button
            className="flex-1 w-20 mt-4 bg-rose-500 hover:bg-rose-800 right-0"
            onClick={finalizePurchase}
          >
            Submit Purchase Record
          </Button>
        ) : null}
      </div>
      {purchases.map((purchase: PurchaseRecord, index: number) => (
        <div key={purchase.id} className="flex gap-4 mt-4">
          <Select>
            <SelectTrigger>
              <SelectValue placeholder="Select" />
            </SelectTrigger>

            <SelectContent>
              {supplyItems.map((item: any, index: number) => (
                <SelectItem key={index} value={item.id}>
                  {item.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          <Input type="number" defaultValue={purchase.quantity} />
        </div>
      ))}
    </div>
  );
};
