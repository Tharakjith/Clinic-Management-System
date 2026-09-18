import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LabtestsRoutingModule } from './labtests-routing.module';
import { LabtestsComponent } from './labtests.component';


@NgModule({
  declarations: [
    LabtestsComponent
  ],
  imports: [
    CommonModule,
    LabtestsRoutingModule
  ]
})
export class LabtestsModule { }
