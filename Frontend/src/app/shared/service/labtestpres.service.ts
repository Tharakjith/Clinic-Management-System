import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
//import { LabAppViewModel } from '../model/lab-app-view-model';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Labtestapp } from '../model/labtestapp';

@Injectable({
  providedIn: 'root'
})
export class LabtestpresService {

  constructor(private http: HttpClient) { }

  getLabTestsForToday(): Observable<Labtestapp[]> {
    return this.http.get<Labtestapp[]>(`${environment.apiUrl}pharmacists/GetLabTestsForToday`);
  }
}
