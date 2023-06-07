import { Component } from '@angular/core';

@Component({
  selector: 'app-rechargepage',
  templateUrl: './rechargepage.component.html',
  styleUrls: ['./rechargepage.component.scss']
})
export class RechargepageComponent {
  
  creanciers = [
    { 
     title:'Maroc Telecom',
     src: '../../assets/imagee.png',
     description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
     alt: 'Clickable Image' 
    },
    { 
      title:'Maroc Telecom',
      src: '../../assets/NBKtAP7j_400x400.png',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      alt: 'Clickable Image' 
    },
    { 
      title:'Maroc Telecom',
      src: '../../assets/NBKtAP7j_400x400.png',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      alt: 'Clickable Image' 
     },
    { 
      title:'Maroc Telecom', 
      src: '../../assets/imagee.png', 
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      alt: 'Clickable Image' ,
    }, 
  ];

  
}
