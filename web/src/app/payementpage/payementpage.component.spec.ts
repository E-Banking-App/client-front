import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PayementpageComponent } from './payementpage.component';

describe('PayementpageComponent', () => {
  let component: PayementpageComponent;
  let fixture: ComponentFixture<PayementpageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PayementpageComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PayementpageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
