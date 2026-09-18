import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(private router:Router){}
  canActivate(
    route: ActivatedRouteSnapshot):
     boolean {

      //current role    ----> local storage
      //exected role  --> app/auth/employee.routing.module.ts
      const currentRole = localStorage.getItem("AccessRole");
      const expectedRole = route.data['role'];

      // if match:true ,show the authorized page
      //else redirect to login
      if(currentRole !==expectedRole){
      localStorage.removeItem("User_name");
             sessionStorage.removeItem("User_name");
             localStorage.removeItem("AccessRole");
             localStorage.removeItem("JWT Token");
            
             this.router.navigate(['auth/login']);
return false;
      }
    return true;
  }
  
}
