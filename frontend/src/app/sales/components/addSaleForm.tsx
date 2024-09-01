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

import { Product } from "@/types/production";

interface AddSaleFormProps {
  products: Product[];
  addSaleData: (data: {
    productId: string | undefined;
    product: string | undefined; // Update the type of 'product' to 'string | undefined'
    quantity: number;
    freebies: number;
    sales: number;
  }) => void;
}

export const AddSaleForm = ({ products, addSaleData }: AddSaleFormProps) => {
  const [selectedProduct, setSelectedProduct] = useState<Product | undefined>(undefined);
  const [quantity, setQuantity] = useState(0);
  const [freebies, setFreebies] = useState(0);
  const [sales, setSales] = useState(0);

  const handleProductChange = (value: string) => {
    const product = products.find((product) => product.code === value);
    setSelectedProduct(product);
  };
  
  const addToTable = () => {
    addSaleData({
      productId: selectedProduct?.id,
      product: selectedProduct?.name,
      quantity: quantity,
      freebies: freebies,
      sales: sales,
    });
  };

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
              <Select
                onValueChange={(value) => handleProductChange(value)}
              >
                <SelectTrigger id="product">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                  {products.map((product) => (
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
        <Button onClick={addToTable}>Add to table</Button>
      </CardFooter>
    </Card>
  );
};
