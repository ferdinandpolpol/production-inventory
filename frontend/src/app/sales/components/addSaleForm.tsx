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

export const AddSaleForm = ({ products, addSaleData }) => {
  const [selectedProduct, setSelectedProduct] = useState("");
  const [quantity, setQuantity] = useState(0);
  const [freebies, setFreebies] = useState(0);
  const [sales, setSales] = useState(0);

  const addToTable = () => {

    if (!selectedProduct || quantity <= 0 || sales <= 0) {
      alert("Please fill in all required fields.");
      return;
    }

    addSaleData({
      product: selectedProduct,
      quantity: quantity,
      freebies: freebies,
      sales: sales
    });

    // Clear the form after submission (optional)
    setSelectedProduct("");
    setQuantity(0);
    setFreebies(0);
    setSales(0);
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Set Product Sale</CardTitle>
      </CardHeader>
      <CardContent>
        <form>
          <div className="grid w-full items-center gap-4">
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="product">Product</Label>
              <Select onValueChange={ (value) => setSelectedProduct(value)} required>
                <SelectTrigger id="product">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                    {  products.map((product) => (
                        <SelectItem key={product.id} value={product.code}>
                            {product.name}
                        </SelectItem>
                    ))}
                </SelectContent>
              </Select>
            </div>


            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="quantitySold">Quantity Sold</Label>
              <Input
                id="quantitySold"
                type="number"
                onChange={(e) => setQuantity(Number(e.target.value))}
                required
              />
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="freebiesSold">Freebies</Label>
              <Input
                id="freebiesSold"
                type="number"
                onChange={(e) => setFreebies(Number(e.target.value))}
                defaultValue={0}
              />
            </div>

            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="sale">Sale (PHP)</Label>
              <Input
                id="sale"
                type="number"
                step={0.01}
                onChange={(e) => setSales(Number(e.target.value))}
                required
              />
            </div>

          </div>
        </form>
      </CardContent>
      <CardFooter className="flex justify-between">
        <Button onClick={ addToTable }>Add to table</Button>
      </CardFooter>
    </Card>
  );
};
