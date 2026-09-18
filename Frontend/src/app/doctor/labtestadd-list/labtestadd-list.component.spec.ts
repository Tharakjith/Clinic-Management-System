import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtestaddListComponent } from './labtestadd-list.component';

describe('LabtestaddListComponent', () => {
  let component: LabtestaddListComponent;
  let fixture: ComponentFixture<LabtestaddListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtestaddListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtestaddListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
