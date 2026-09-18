import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/shared/service/auth.service';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {

  constructor(public authService: AuthService, public router: Router) { }

  ngOnInit(): void {
  }

  isLoggedIn(): boolean {
    const role = localStorage.getItem('AccessRole');
    const user = localStorage.getItem('User_name');
    const isLoginRoute = this.router.url === '/auth/login' || this.router.url === '/';
    return !!(role && user && !isLoginRoute);
  }

  getUserName(): string {
    return localStorage.getItem('User_name') || 'User';
  }

  getRoleId(): number {
    return Number(localStorage.getItem('AccessRole') || 0);
  }

  getRoleName(): string {
    const roleId = this.getRoleId();
    switch (roleId) {
      case 1: return 'Administrator';
      case 2: return 'Doctor';
      case 3: return 'Receptionist';
      case 4: return 'Pharmacist';
      case 5: return 'Lab Technician';
      default: return 'Staff';
    }
  }

  getDashboardRoute(): string {
    const roleId = this.getRoleId();
    switch (roleId) {
      case 1: return '/auth/admin';
      case 2: return '/auth/doctor';
      case 3: return '/patients/list';
      case 4: return '/auth/pharmacists';
      case 5: return '/auth/labtechnician';
      default: return '/auth/login';
    }
  }

  onLogout(): void {
    if (confirm('Are you sure you want to sign out?')) {
      this.authService.logOutRemoveItems();
    }
  }

}
