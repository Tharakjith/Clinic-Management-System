import { Injectable } from '@angular/core';
import { Staff } from '../model/staff';
import { Department } from '../model/department';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable, throwError } from 'rxjs';


@Injectable({
  providedIn: 'root',
})
export class StaffService {
  // List of staffs and departments
  staffs: Staff[] = [];
  department: Department[] = [];
  formStaffData: Staff = new Staff();
  doj: any;
  createdDate: any;
  dob:any;

  constructor(private httpClient: HttpClient) {}

  ///1- Get All Employees
  getAllStaffs(): void {
    this.httpClient.get(environment.apiUrl + 'Staffs')

      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.staffs = response.Value;
          console.log(this.staffs);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }
  // 2- Insert employee
  insertStaffs(staff:Staff): Observable<any>{
    console.log("Insert: In Service");
    console.log(staff);
    return this.httpClient.post(environment.apiUrl+'Staffs',staff);
    }

  // 3. Get all departments
  getAllDepartments(): void {
    this.httpClient.get(environment.apiUrl + 'Staffs/v2')
      .toPromise()
      .then((response?: any) => {
        if (response.Value) {
          this.department= response.Value;
          console.log(this.department);
        }
      })
      .catch((error) => {
        console.log('Error occured:', error);
      });
  }
  

  // 4. Update a staff
  UpdateStaffs(staff:Staff):Observable<any>{
    console.log("Update : In service");
    return this.httpClient.put(environment.apiUrl+'staffs/'+staff.StaffId,staff);
  }

  // 5. Delete a staff
  deleteStaff(id: number): Observable<any> {
    return this.httpClient.delete(environment.apiUrl + 'Staffs/' + id);
  }
}