import { ProductionForm } from "./components/productionForm";
import { request } from "@/utils/request";

export async function getProducts() {
  const response = await request("/product/", { method: "GET" });
  const products = response.map((product: any) => ({
    id: product.id,
    name: product.name,
    price: product.price,
    unit: product.unit,
  }));

  return products;
}

export default async function ProductionPage() {
  const products = await getProducts();

  return (
    <div>
      <ProductionForm products={products} />
    </div>
  );
}
