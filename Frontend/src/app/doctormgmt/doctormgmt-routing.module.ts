import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DoctormgmtListComponent } from './doctormgmt-list/doctormgmt-list.component';
import { DoctormgmtAddComponent } from './doctormgmt-add/doctormgmt-add.component';
import { DoctormgmtEditComponent } from './doctormgmt-edit/doctormgmt-edit.component';

const routes: Routes = [ { path: 'list', component: DoctormgmtListComponent },
  { path: 'add', component: DoctormgmtAddComponent },
  { path: 'edit/:id', component: DoctormgmtEditComponent },];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DoctormgmtRoutingModule { }