"use client";

import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";

import { useState, useEffect } from "react";
import { Customer } from "@/types/customer";

export const SelectVendorForm = ({ suppliers, supplierData }) => {
  const [selectedSupplier, setSelectedSupplier] = useState(null);
  const [purchaseAmount, setPurchaseAmount] = useState(0);
  const [purchaseNotes, setPurchaseNotes] = useState("");
  const [supplyDate, setSupplyDate] = useState(new Date().toISOString().split("T")[0]);

  useEffect(() => { 
    supplierData({selectedSupplier, purchaseAmount, purchaseNotes, supplyDate});
  }, [selectedSupplier, purchaseAmount, purchaseNotes, supplyDate]);

  const handleSupplierChange = (value) => {
    const supplier = suppliers.find((supplier) => supplier.name === value);
    setSelectedSupplier(supplier);
  }

  return (
    <Card className="h-full">
      <CardHeader>
        <CardTitle>Select a Supplier / Vendor</CardTitle>
      </CardHeader>

      <CardContent>
        <form>
          <div className="grid w-full items-center gap-4">
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="supplyDate">Supply Date</Label>
              <Input
                id="supplyDate"
                type="date"
                defaultValue={new Date().toISOString().split("T")[0]}
                onChange={(e) => setSupplyDate(e.target.value)}
              />
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="supplier">Supplier / Vendor</Label>
              <Select onValueChange={ (value) => handleSupplierChange(value) }>
                <SelectTrigger id="supplier">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                  {suppliers.map((supplier: Customer) => (
                    <SelectItem key={supplier.id} value={supplier.name}>
                      {supplier.name}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="purchaseAmount">Purchase Amount (₱)</Label>
              <Input
                id="purchaseAmount"
                type="number"
                step={0.01}
                defaultValue={0}
                onChange={(e) => setPurchaseAmount(parseFloat(e.target.value))}
              />
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="purchaseNotes">Purchase Notes</Label>
              <Textarea 
                id="purchaseAmount" placeholder="Enter notes here..." 
                onChange={(e) => setPurchaseNotes(e.target.value)}
              />
            </div>
          </div>
        </form>
      </CardContent>
      <CardFooter className=""></CardFooter>
    </Card>
  );
};
