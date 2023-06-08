import { Component } from '@angular/core';
import {MatTreeFlatDataSource, MatTreeFlattener} from '@angular/material/tree';
import {FlatTreeControl} from '@angular/cdk/tree';

interface CreancierNode {
  name: string;
  children?: CreancierNode[];
}

const TREE_DATA: CreancierNode[] = [
  {
    name: 'IAM Recharge',
    children: [{name: 'Telephonie SIM'}, {name: 'Internet SIM'}],
  },
];

interface ExampleFlatNode {
  expandable: boolean;
  name: string;
  level: number;
}

@Component({
  selector: 'app-rechargepage',
  templateUrl: './rechargepage.component.html',
  styleUrls: ['./rechargepage.component.scss']
})
export class RechargepageComponent {

  private _transformer = (node: CreancierNode, level: number) => {
    return {
      expandable: !!node.children && node.children.length > 0,
      name: node.name,
      level: level,
    };
  };

  treeControl = new FlatTreeControl<ExampleFlatNode>(
    (node: ExampleFlatNode) => node.level,
    (node: ExampleFlatNode) => node.expandable,
  );

  treeFlattener = new MatTreeFlattener(
    this._transformer,
    node => node.level,
    node => node.expandable,
    node => node.children,
  );

  dataSource = new MatTreeFlatDataSource(this.treeControl, this.treeFlattener);

  constructor() {
    this.dataSource.data = TREE_DATA;
  }

  hasChild = (_: number, node: ExampleFlatNode) => node.expandable;

  creanciers = [
    {
     name:'Maroc Telecom',
     code:'Code34532',
     category: "RECHARGE",
     src: '../../assets/imagee.png',
     creance: [
      {
        code: "Code0324",
        name: "Telephonie SIM",
      }
     ]
    },
    {
      name:'INWI',
      code:'Code34532',
      category: "RECHARGE",
      src: '../../assets/NBKtAP7j_400x400.png',
      creance: [
        {
          code: "Code0324",
          name: "Telephonie SIM",
        }
     ]
    },
  ];
}
