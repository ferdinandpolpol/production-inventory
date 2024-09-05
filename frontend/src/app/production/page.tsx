"use client";

import { ProductionForm } from "./components/productionForm";
import { ProductionTable } from "./components/productionTable";

import { request } from "@/utils/request";
import { useEffect, useState } from "react";
import { Production } from "@/types/production";

interface ProductionResponse {
  results: Production[];
}

export default function ProductionPage() {
  console.log("ProductionPage");
  const [productionData, setProductionData] = useState<Production[]>([]);

  useEffect(() => {
    async function getProductionData() {
      try {
        const response: ProductionResponse = await request("/production/", {
          method: "GET",
        });
        setProductionData(response.results);
      } catch (error) {
        console.error(error);
      }
    }
    getProductionData();
  }, []);

  const addProduction = (newProduction: Production) => {
    setProductionData((prevData) => [newProduction, ...prevData]);
  };

  return (
    <div className="mt-20 w-[90vw] h-[90vw]">
      <div className="flex md:flex-row sm:flex-col">
        <div className="w-full p-4">
          <ProductionForm addProduction={addProduction} />
        </div>

        <div className="w-full p-4">
          <ProductionTable productionData={productionData} />
        </div>
      </div>
    </div>
  );
}
