"use client";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Production } from "@/types/production";

export const ProductionTable = ({
  productionData,
}: {
  productionData: Production[];
}) => {
  return (
    <div className="h-[63vh] relative overflow-auto bg-slate-100 rounded">
      <Table>
        <TableHeader className="sticky top-0 bg-secondary">
          <TableRow>
            <TableHead>Product</TableHead>
            <TableHead>Quantity</TableHead>
            <TableHead>Date</TableHead>
          </TableRow>
        </TableHeader>

        <TableBody className="">
          {productionData?.map((production: Production) => (
            <TableRow key={production.id}>
              <TableCell>{production.product_name}</TableCell>
              <TableCell>{production.quantity}</TableCell>
              <TableCell>{production.date}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
};
