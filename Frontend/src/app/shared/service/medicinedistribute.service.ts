import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Medicinedistribute } from '../model/medicinedistribute';
import { Observable } from 'rxjs';
import { Patient } from '../model/patient';
import { Prescription } from '../model/prescription';
import { Medicinedetails } from '../model/medicinedetails';

@Injectable({
  providedIn: 'root'
})
export class MedicinedistributeService {

  //declare variables
  //list of employees

  medicinedistribute:Medicinedistribute[]=[];
  patient: Patient[] = [];
  prescription: Prescription[] = [];
  medicnedetails:Medicinedetails[] = [];
  formMedicinedistributeData:Medicinedistribute=new Medicinedistribute();
  DistributionDate: any;

  constructor(private httpClient:HttpClient) {}
  
  getPrescriptionDetails(prescriptionId: number): Observable<Medicinedistribute> {
    return this.httpClient.get<Medicinedistribute>(`${environment.apiUrl}pharmacists/vm3/${prescriptionId}`);
  }

    getAllMedicineDistribute():void{
      this.httpClient.get(environment.apiUrl+'pharmacists/vm3')
      .toPromise( )
      .then((response:any)=>{
        if(response ?.Value){
          this.medicinedistribute=response.Value;
          console.log(this.medicinedistribute);
        }
       
  
      })
      .catch((error)=>{
        console.log('Error occured: ',error);
      
    });
  }
  
  //2-insert an employee
  
  insertMedicineDistribute(medicinedistributes:Medicinedistribute):Observable<any>{
    console.log("Insert : In service");
    return this.httpClient.post(environment.apiUrl+'pharmacists/add-md',medicinedistributes);
  } 
  }