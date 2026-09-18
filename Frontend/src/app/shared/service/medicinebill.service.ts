import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Medicinebill } from '../model/medicinebill';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class MedicinebillService {

  //declare variables
  //list of employees

  medicinebills: Medicinebill[]=[];
  formMedicinebillData:Medicinebill=new Medicinebill();
  BillDateTime: any;


  constructor(private httpClient:HttpClient) { }
  getAllMedicineBill():void{
    this.httpClient.get(environment.apiUrl+'pharmacists/vm2')
    .toPromise()
    .then((response:any)=>{
      if(response ?.Value){
        this.medicinebills=response.Value;
        console.log(this.medicinebills);
      }
     

    })
    .catch((error)=>{
      console.log('Error occured: ',error);
    
  });
}
}
