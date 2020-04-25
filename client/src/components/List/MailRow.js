import React, { Component } from "react";
import { Table, Button } from "semantic-ui-react";
import { Link } from "react-router-dom";
import mailInform from "../../pages/mailInform";

class MailRow extends Component {
<<<<<<< HEAD
=======
  mailLink = () => {
    window.open(
      window.location.pathname + "/mailInform",
      "QR코드",
      "width=770, height=800, location = no"
    );
  };
>>>>>>> 3000c8dc2f47d0d1706f1407d3a55ade036e43d2
  data = () => {
    console.log(this.props);
    //return this.props.history.push(window.location.pathname + "/test");
    window.open(
      window.location.pathname + "/test/" + this.props.index,
      "QR코드",
      "width=770, height=800, location = no"
    );
  };
  qrPopup = () => {
    window.open(
      "/qrCode/" + this.props.index,
      "QR코드",
      "width=508, height=453, location = no"
    );
  };

  render() {
    const { Row, Cell } = Table;
    return (
      <Row>
        <Cell>{this.props.data.senderName}</Cell>
        <Cell>{this.props.data.senderAddress}</Cell>
        <Cell>{this.props.data.senderPhone}</Cell>
<<<<<<< HEAD
        <Cell>{this.props.data.productName}</Cell>
=======
        <Cell>{this.props.data.mailName}</Cell>
>>>>>>> 3000c8dc2f47d0d1706f1407d3a55ade036e43d2
        <Cell>
          {" "}
          {(() => {
            switch (this.props.data.complete) {
              case false:
                return "배송중";
              case true:
                return "배송완료";
            }
          })()}
        </Cell>
        <Cell>
          <Button color="green" basic onClick={this.qrPopup}>
            클릭
          </Button>
        </Cell>
        <Cell>
<<<<<<< HEAD
          <Button color="purple" basic onClick={this.data}>
            클릭
          </Button>
=======
          <Button color="purple" basic onClick={this.mailLink}>
            클릭
          </Button>
          <Button color="purple" basic onClick={this.data}>
            test
          </Button>
>>>>>>> 3000c8dc2f47d0d1706f1407d3a55ade036e43d2
        </Cell>
      </Row>
    );
  }
}

export default MailRow;
