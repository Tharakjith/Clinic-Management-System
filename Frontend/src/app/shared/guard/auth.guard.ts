import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../service/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(private authService: AuthService, private router: Router) { }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    if (!this.authService.isAuthenticated()) {
      this.router.navigate(['auth/login'], { queryParams: { returnUrl: state.url } });
      return false;
    }

    // Role check if configured in route data
    const expectedRoles = route.data['roles'] as Array<number>;
    if (expectedRoles && expectedRoles.length > 0) {
      const userRole = this.authService.getRoleId();
      if (!expectedRoles.includes(userRole)) {
        // Redirect to user's assigned dashboard based on role
        this.redirectToRoleDashboard(userRole);
        return false;
      }
    }

    return true;
  }

  private redirectToRoleDashboard(roleId: number): void {
    switch (roleId) {
      case 1:
        this.router.navigate(['auth/admindash']);
        break;
      case 2:
        this.router.navigate(['auth/doctordash']);
        break;
      case 3:
        this.router.navigate(['auth/receptionistdash']);
        break;
      case 4:
        this.router.navigate(['auth/pharmacistdash']);
        break;
      case 5:
        this.router.navigate(['auth/labtechniciandash']);
        break;
      default:
        this.router.navigate(['auth/login']);
        break;
    }
  }
}
