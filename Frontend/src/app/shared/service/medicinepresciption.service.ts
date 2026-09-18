import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Medicinepresciption } from '../model/medicinepresciption';
import { environment } from 'src/environments/environment';
import { Medicinedetails } from '../model/medicinedetails';

@Injectable({
  providedIn: 'root'
})
export class MedicinepresciptionService {

  //declare variables
  //list of employees

  medicineprescription:Medicinepresciption[]=[];
  medicinedetails:Medicinedetails[]=[];
  formMedicinepresciptionData:Medicinepresciption = new Medicinepresciption();
  DateOfJoining: any;

  constructor(private httpClient:HttpClient) { }

  //1- Get all employees

  getAllMedicinePrescriptions():void{
    this.httpClient.get(environment.apiUrl+'pharmacists/vm1')
    .toPromise()
    .then((response:any)=>{
      if(response ?.Value){
        this.medicineprescription=response.Value;
        console.log(this.medicineprescription);
      }

    })
    .catch((error)=>{
      console.log('Error occured: ',error);
    
  });
}

//3-Get all medicine details

getAllMedicineDetails():void{
  this.httpClient.get(environment.apiUrl+'Pharmacists')
  .toPromise()
  .then((response:any)=>{
    if(response ?.Value){
      this.medicinedetails=response.Value;
      console.log(this.medicinedetails);
    }
   

  })
  .catch((error)=>{
    console.log('Error occured: ',error);
  
});
}


}
