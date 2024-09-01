import { ProductionForm } from "./components/productionForm";
import { ProductionTable } from "./components/productionTable";


export default async function ProductionPage() {

  return (
    <div className="flex flex-col md:flex-row">
      <div className="w-full p-4 max-sm:mt-96">
        <ProductionForm />
      </div>

      <div className="w-full p-4">
        <ProductionTable />
      </div>
    </div>
  
  );
}
