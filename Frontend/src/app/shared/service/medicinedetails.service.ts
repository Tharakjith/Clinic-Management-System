import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Medicinedetails } from '../model/medicinedetails';
import { Observable } from 'rxjs';
import { Category } from '../model/category';

@Injectable({
  providedIn: 'root'
})
export class MedicinedetailsService {

  //declare variables
  //list of employees

  medicineDetails: Medicinedetails[] = [];
  category: Category[] = [];
  formMedicineDetailsData: Medicinedetails = new Medicinedetails();
  DateOfJoining: any;
  ManufacturingDate: any;
  ExpiryDate: any;

  //DI: Httpclient

  constructor(private httpClient: HttpClient) { }


  //1- Get all MedicineDetails

  getAllMedicineDetails(): void {
    this.httpClient.get(environment.apiUrl + 'Pharmacists')
      .toPromise()
      .then((response: any) => {
        if (response?.Value) {
          this.medicineDetails = response.Value;
          console.log(this.medicineDetails);
        }


      })
      .catch((error) => {
        console.log('Error occured: ', error);

      });
  }

  //2-insert an Medicine

  insertMedicineDetails(medicineDetails: Medicinedetails): Observable<any> {
    console.log("Insert : In service");
    return this.httpClient.post(environment.apiUrl + 'Pharmacists', medicineDetails);
  }


  //3-Get all category

  getAllCategory(): void {
    this.httpClient.get(environment.apiUrl + 'pharmacists/v2')
      .toPromise()
      .then((response: any) => {
        if (response?.Value) {
          this.category = response.Value;
          console.log(this.category);
        }


      })
      .catch((error) => {
        console.log('Error occured: ', error);

      });
  }

  // Update a Medicine
  updateMedicineDetails(medicineDetails: Medicinedetails): Observable<any> {
    console.log('Update : In service');
    return this.httpClient.put(environment.apiUrl + 'Pharmacists/' + medicineDetails.MedicineId, medicineDetails);
  }

  // Delete a Medicine
  deleteMedicine(id: number): Observable<any> {
    return this.httpClient.delete(environment.apiUrl + 'Pharmacists/' + id);
  }

}
