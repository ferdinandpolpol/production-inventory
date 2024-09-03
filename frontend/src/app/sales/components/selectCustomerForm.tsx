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

import { useState, useEffect } from "react";
import { Customer } from "@/types/customer";

interface SelectCustomerFormProps {
  customers: Customer[];
  saleInitialData: (data: {
    date: string;
    salesType: string;
    customer: string;
    customerId: string;
  }) => void;
}

export const SelectCustomerForm = ({
  customers,
  saleInitialData,
}: SelectCustomerFormProps) => {
  const deliveryTypes = ["DELIVERY", "MALL", "WALK-IN"];

  const [inputDate, setInputDate] = useState(
    new Date().toISOString().split("T")[0],
  );
  const [selectedSalesType, setSelectedSalesType] = useState("");
  const [selectedCustomer, setSelectedCustomer] = useState("");

  useEffect(() => {
    saleInitialData({
      date: inputDate,
      salesType: selectedSalesType,
      customer: selectedCustomer,
      customerId:
        customers.find((customer) => customer.name === selectedCustomer)?.id ||
        "",
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [inputDate, selectedSalesType, selectedCustomer]);

  return (
    <Card className="h-full">
      <CardHeader>
        <CardTitle>Select a Customer</CardTitle>
      </CardHeader>

      <CardContent>
        <form>
          <div className="grid w-full items-center gap-4">
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
              <Select onValueChange={(value) => setSelectedSalesType(value)}>
                <SelectTrigger id="salesType">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                  {deliveryTypes.map((deliveryType) => (
                    <SelectItem key={deliveryType} value={deliveryType}>
                      {deliveryType}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="customer">Customer</Label>
              <Select onValueChange={(value) => setSelectedCustomer(value)}>
                <SelectTrigger id="customer">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                  {customers.map((customer) => (
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
      <CardFooter className=""></CardFooter>
    </Card>
  );
};
