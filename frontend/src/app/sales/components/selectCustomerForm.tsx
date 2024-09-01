"use client";


import { Button } from "@/components/ui/button";
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

import { useState } from "react";

export const SelectCustomerForm = ({ customers, saleInitialData }) => {
  const deliveryTypes = ["DELIVERY", "MALL", "WALK-IN"];

  const [inputDate, setInputDate] = useState(new Date().toISOString().split("T")[0]);
  const [selectedSalesType, setSelectedSalesType] = useState("");
  const [selectedCustomer, setSelectedCustomer] = useState("");

  const handleNext = () => {
    saleInitialData({
      date: inputDate,
      salesType: selectedSalesType,
      customer: selectedCustomer
    });
  }

  return (
    <Card>

      <CardHeader>
        <CardTitle>Select a Customer</CardTitle>
      </CardHeader>
      <CardContent>
        <form>
          <div className="grid h-full w-full items-center gap-4">
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="saleDate">Sale Date</Label>
              <Input
                id="saleDate"
                type="date"
                defaultValue={new Date().toISOString().split("T")[0]}
                onChange={(e) => setInputDate(e.target.value)}
              />
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="salesType">Sales Type</Label>
              <Select onValueChange={ (value) => setSelectedSalesType(value)}>
                <SelectTrigger id="salesType">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                    {  deliveryTypes.map((deliveryType) => (
                        <SelectItem key={deliveryType} value={deliveryType}>
                            {deliveryType}
                        </SelectItem>
                    ))}
                </SelectContent>
              </Select>
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="customer">Customer</Label>
              <Select onValueChange={ (value) => setSelectedCustomer(value) }>
                <SelectTrigger id="customer">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                    {  customers.map((customer) => (
                        <SelectItem key={customer.id} value={customer.name}>
                            {customer.name}
                        </SelectItem>
                    ))}
                </SelectContent>
              </Select>
            </div>
          </div>
        </form>
      </CardContent>
      <CardFooter className="flex justify-between">
        <Button onClick={ handleNext }>Next</Button>
      </CardFooter>
    </Card>
  );
};
