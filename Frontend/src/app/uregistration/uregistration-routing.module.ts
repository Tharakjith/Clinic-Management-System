import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { UregistrationListComponent } from './uregistration-list/uregistration-list.component';
import { UregistrationAddComponent } from './uregistration-add/uregistration-add.component';
import { UregistrationEditComponent } from './uregistration-edit/uregistration-edit.component';

const routes: Routes = [{ path: 'list', component: UregistrationListComponent },
  { path: 'add', component: UregistrationAddComponent },
  { path: 'edit/:id', component: UregistrationEditComponent },];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class UregistrationRoutingModule { }