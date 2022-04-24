// Next.js API route support: https://nextjs.org/docs/api-routes/introduction

import { NextApiResponse } from "next";

type Data={
  name:string;
  email:string;

}

export default function handler(req:NextApiResponse, res:NextApiResponse<Data>) {
  res.status(200).json({
     name: 'John Doe' ,
     email:"email@mail.com"
  })
}
