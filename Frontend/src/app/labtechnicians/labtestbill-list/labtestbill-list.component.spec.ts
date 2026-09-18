import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtestbillListComponent } from './labtestbill-list.component';

describe('LabtestbillListComponent', () => {
  let component: LabtestbillListComponent;
  let fixture: ComponentFixture<LabtestbillListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtestbillListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtestbillListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
