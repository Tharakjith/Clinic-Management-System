import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { environment } from 'src/environments/environment';

export interface AuthResponse {
  token?: string;
  Token?: string;
  username?: string;
  Username?: string;
  roleId?: number;
  RoleId?: number;
  roleName?: string;
  RoleName?: string;
  doctorId?: number | null;
  DoctorId?: number | null;
  staffId?: number;
  StaffId?: number;
  registrationId?: number;
  RegistrationId?: number;
  expiresInMinutes?: number;
  ExpiresInMinutes?: number;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private httpClient: HttpClient, private router: Router) { }

  /**
   * Secure POST login sending credentials in the HTTP request body.
   */
  public loginVerify(credentials: { Username: string; Password: string }): Observable<AuthResponse> {
    return this.httpClient.post<AuthResponse>(environment.apiUrl + 'Logins/login', credentials)
      .pipe(
        tap((res: any) => {
          const token = res.Token || res.token;
          const username = res.Username || res.username;
          const roleId = res.RoleId !== undefined ? res.RoleId : res.roleId;
          const roleName = res.RoleName || res.roleName || '';
          const doctorId = res.DoctorId !== undefined ? res.DoctorId : res.doctorId;
          const staffId = res.StaffId !== undefined ? res.StaffId : res.staffId;

          if (token) {
            localStorage.setItem('JWT Token', token);
            localStorage.setItem('User_name', username || '');
            localStorage.setItem('AccessRole', roleId ? roleId.toString() : '');
            localStorage.setItem('RoleName', roleName);
            if (doctorId) {
              localStorage.setItem('DoctorId', doctorId.toString());
            } else {
              localStorage.removeItem('DoctorId');
            }
            if (staffId) {
              localStorage.setItem('StaffId', staffId.toString());
            }
          }
        })
      );
  }

  public getToken(): string | null {
    return localStorage.getItem('JWT Token');
  }

  public isAuthenticated(): boolean {
    const token = this.getToken();
    return !!token;
  }

  public getUsername(): string {
    return localStorage.getItem('User_name') || '';
  }

  public getRoleId(): number {
    const role = localStorage.getItem('AccessRole');
    return role ? parseInt(role, 10) : 0;
  }

  public getRoleName(): string {
    return localStorage.getItem('RoleName') || '';
  }

  public getDoctorId(): number | null {
    const docId = localStorage.getItem('DoctorId');
    return docId ? parseInt(docId, 10) : null;
  }

  /**
   * Clear all session and local storage keys and redirect to login.
   */
  public logOutRemoveItems(): void {
    localStorage.removeItem('User_name');
    localStorage.removeItem('AccessRole');
    localStorage.removeItem('RoleName');
    localStorage.removeItem('DoctorId');
    localStorage.removeItem('StaffId');
    localStorage.removeItem('JWT Token');
    this.router.navigate(['auth/login']);
  }
}
