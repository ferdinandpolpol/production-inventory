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
  finalizePurchase: (records: PurchaseRecord[]) => void;
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
  const [purchases, setPurchases] = useState<PurchaseRecord[]>([]);

  const addNewPurchase = () => {
    const newPurchase = { id: Date.now(), quantity: 1, item: "" };
    setPurchases((prev) => [...prev, newPurchase]);
  };

  const handleAddPurchase = (id: number, value: string) => {
    setPurchases((prev) =>
      prev.map((purchase) =>
        purchase.id === id ? { ...purchase, item: value } : purchase
      )
    );
  };

  const handleQuantityChange = (id: number, value: number) => {
    setPurchases((prev) =>
      prev.map((purchase) =>
        purchase.id === id ? { ...purchase, quantity: value } : purchase
      )
    );
  };

  const handleFinalizePurchase = () => {
    finalizePurchase(purchases);
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
        {purchases.length > 0 && (
          <Button
            className="flex-1 w-20 mt-4 bg-rose-500 hover:bg-rose-800 right-0"
            onClick={handleFinalizePurchase}
          >
            Submit Purchase Record
          </Button>
        )}
      </div>
      {purchases.map((purchase) => (
        <div key={purchase.id} className="flex gap-4 mt-4">
          <Select
            onValueChange={(value) => handleAddPurchase(purchase.id, value)}
          >
            <SelectTrigger>
              <SelectValue placeholder="Select" />
            </SelectTrigger>

            <SelectContent>
              {supplyItems.map((item) => (
                <SelectItem key={item.id} value={item.id}>
                  {item.name} / {item.unit}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          <Input
            type="number"
            defaultValue={purchase.quantity}
            onChange={(e) =>
              handleQuantityChange(purchase.id, Number(e.target.value))
            }
          />
        </div>
      ))}
    </div>
  );
};
