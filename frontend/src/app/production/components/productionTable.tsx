'use client'


import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
  } from "@/components/ui/table"
import { request } from "@/utils/request";
import { useEffect, useState } from "react";


interface Production {
    id: string;
    product_name: string;
    quantity: number;
    date: string;
}

interface ProductionResponse {
    results: Production[];
}
  

export const ProductionTable = async () => {
    const [productionData, setProductionData] = useState<Production[]>([]);
    useEffect(() => {
        async function getProductionData() {
            try {
                const response: ProductionResponse = await request("/production/", { method: "GET" });
                setProductionData(response.results);
            } catch (error) {
                console.error(error);
            }
        }
    }, [])

    return (
        <Table className="bg-slate-100 rounded max-h-80 overflow-y-auto relative">
        <TableHeader>
        <TableRow>
            <TableHead>Product</TableHead>
            <TableHead>Quantity</TableHead>
            <TableHead>Date</TableHead>
        </TableRow>
        </TableHeader>

        <TableBody className="overflow-y-auto block h-[500px]">
        {productionData?.map((production: Production) => (
            <TableRow key={production.id}>
            <TableCell>{production.product_name}</TableCell>
            <TableCell>{production.quantity}</TableCell>
            <TableCell>{production.date}</TableCell>
            </TableRow>
        ))}
        </TableBody>
        </Table>
    );
};