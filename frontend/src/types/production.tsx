interface Production {
  id: string;
  product_name: string;
  quantity: number;
  date: string;
}

interface Ingredient {
  id: string;
  main_ingredient: boolean;
  ingredient: {
    name: string;
    id: string;
    price: number;
    unit: string;
  };
  multiplied_by_main_ingredient: boolean;
  multiplied_by_production: boolean;
  quantity: number;
}
interface Product {
  id: string;
  code: string;
  name: string;
  recipe: {
    ingredients: Ingredient[];
  };
}

export type { Production, Ingredient, Product };
