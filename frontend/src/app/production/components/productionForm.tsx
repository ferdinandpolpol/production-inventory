"use client";

import { useEffect, useState } from "react";

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

import { request } from "@/utils/request";

import { Ingredient, Product } from "@/types/production";

interface ProductionFormProps {
  products: Product[];
}

export const ProductionForm = ({
  addProduction,
}: {
  addProduction: (data: any) => void;
}) => {
  const [products, setProducts] = useState<Product[]>([]);
  const [showMainIngredient, setShowMainIngredient] = useState(false);
  const [mainIngredient, setMainIngredient] = useState<
    Ingredient | string | undefined
  >(undefined);
  const [otherIngredients, setOtherIngredients] = useState<
    Ingredient[] | undefined
  >([]);
  const [selectedProduct, setSelectedProduct] = useState<Product | undefined>(
    undefined,
  );
  const [quantity, setQuantity] = useState(0);
  const [mainIngredientUsed, setMainIngredientUsed] = useState(0);
  const [inputDate, setInputDate] = useState(
    new Date().toISOString().split("T")[0],
  );

  useEffect(() => {
    async function getProducts() {
      try {
        const response = await request("/product/", { method: "GET" });
        setProducts(response);
      } catch (error) {
        console.error(error);
      }
    }
    getProducts();
  }, []);

  const handleProductChange = (value: string) => {
    const product = products.find((product: Product) => product.code === value);
    setSelectedProduct(product);

    const _mainIngredient = product?.recipe?.ingredients.find(
      (ingredient: Ingredient) => ingredient.main_ingredient,
    );
    const _otherIngredients = product?.recipe?.ingredients.filter(
      (ingredient: Ingredient) => !ingredient.main_ingredient,
    );

    setOtherIngredients(_otherIngredients);
    setMainIngredient(_mainIngredient);

    console.log(_mainIngredient);
    if (_mainIngredient?.id) {
      setShowMainIngredient(true);
      setMainIngredient(_mainIngredient.ingredient.name);
    } else {
      setShowMainIngredient(false);
      setMainIngredient("");
    }
  };

  const createProductionData = async (
    e: React.MouseEvent<HTMLButtonElement>,
  ) => {
    e.preventDefault();

    const ingredientMap = (otherIngredients ?? []).map(
      (ingredient: Ingredient) => {
        let quantityUsed = 0;

        if (ingredient.multiplied_by_main_ingredient)
          quantityUsed = mainIngredientUsed * ingredient.quantity;
        else if (ingredient.multiplied_by_production) quantityUsed = quantity;

        return {
          ingredient: ingredient.ingredient.id,
          quantity: quantityUsed,
        };
      },
    );

    const productionData = {
      product: selectedProduct?.id,
      quantity: quantity,
      production_date: inputDate,
      ingredients: ingredientMap,
    };

    try {
      const response = await request("/production/", {
        method: "POST",
        body: JSON.stringify(productionData),
      });

      console.log(response);
      addProduction({
        production_id: response,
        product_name: selectedProduct?.name,
        quantity: quantity,
        date: inputDate,
      });
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <Card className="h-[50vh]">
      <CardHeader>
        <CardTitle>Create production</CardTitle>
      </CardHeader>
      <CardContent>
        <form>
          <div className="grid w-full items-center gap-4">
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="productionDate">Production Date</Label>
              <Input
                id="productionDate"
                type="date"
                defaultValue={new Date().toISOString().split("T")[0]}
                onChange={(e) => setInputDate(e.target.value)}
              />
            </div>
            <div className="flex flex-col space-y-1.5">
              <Label htmlFor="productionProduct">Product</Label>
              <Select onValueChange={handleProductChange}>
                <SelectTrigger id="productionProduct">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>

                <SelectContent position="popper">
                  {products.map((product: Product) => (
                    <SelectItem key={product.id} value={product.code}>
                      {product.name}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            {selectedProduct ? (
              <div className="flex flex-col space-y-1.5">
                <Label htmlFor="productionQuantity">Quantity</Label>
                <Input
                  id="productionQuantity"
                  type="number"
                  placeholder="Quantity"
                  onChange={(e) => setQuantity(Number(e.target.value))}
                />
              </div>
            ) : null}

            {showMainIngredient ? (
              <div className="flex flex-col space-y-1.5">
                <Label htmlFor="mainIngredientUsed">
                  # of {String(mainIngredient)} Used
                </Label>
                <Input
                  id="mainIngredientUsed"
                  type="number"
                  placeholder="Quantity"
                  onChange={(e) =>
                    setMainIngredientUsed(Number(e.target.value))
                  }
                />
              </div>
            ) : null}
          </div>
        </form>
      </CardContent>
      <CardFooter className="flex justify-between">
        <Button onClick={createProductionData}>Create</Button>
      </CardFooter>
    </Card>
  );
};
