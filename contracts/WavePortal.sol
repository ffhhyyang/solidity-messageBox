// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("We have been constructed!");
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        uint256 randomNumber = (block.difficulty + block.timestamp + seed) %
            100;
        console.log("Random # generated: %s", randomNumber);

        seed = randomNumber;

        if (randomNumber < 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than they contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}


//0x5FbDB2315678afecb367f032d93F642f64180aa3

















<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>请留言</title>

</head>

<body>
    <div id="app"></div>
    <script crossorigin src="https://unpkg.com/react@16/umd/react.development.js"></script>
    <script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.development.js"></script>
    <script crossorigin src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>

    <script type="text/babel">
        class Text extends React.Component {
            constructor(props) {
                super(props);
            }
            // 删除
            deletData = (id) => {
                let index = this.props.textBox.findIndex(e => {
                    return e[this.props.contId] == id
                })
                this.props.textBox.splice(index,1)
                this.props.saveData(this.props.textBox)
            }
            render() {
                return (
                    <ul id="textBox">
                        {
                            this.props.textBox.map(i => {
                                return <li key={i.id}>{i.data} <button onClick={(e) => this.deletData(i.id, e)}>删除</button></li>
                            })
                        }
                    </ul>
                )
            }
        }
        class App extends React.Component {
            constructor(props) {
                super(props)
                this.state = {
                    textarea: '',
                    jsonKey: 'react-demo6',
                    contId: 'id',
                    textBox: [],
                }
            }
            componentDidMount() {
                this.readData()
            }
            // 取值
            readData = (props) => {
                let localJson = localStorage.getItem(this.state.jsonKey)
                if (localJson !== null && localJson.length > 0) {
                    this.setState({ textBox: JSON.parse(localJson) })
                }else{
                 const json = [
                     {
                         id: 1,
                         data: '文章很好!'
                     },
                     {
                         id: 2,
                         data: '哈哈哈哈哈'
                     },
                 ]
                 let jsonData = JSON.stringify(json)
                 localStorage.setItem('react-demo6', jsonData)
                }
            }
            // 存值
            saveData = (arrData) => {
                let localJson = JSON.stringify(arrData)
                localStorage.setItem(this.state.jsonKey, localJson)
                this.setState({ textBox: JSON.parse(localJson) })
            }
            // 新增
            addData = (data) => {
                let arr = this.state.textBox
                let newObj = {
                    "data": this.state.textarea
                }
                // 3.自动生成主键id
                let newId = arr.length > 0 ? arr[arr.length - 1][this.state.contId] + 1 : 1
                newObj[this.state.contId] = newId
                // 4.将对象增加到数组中
                arr.push(newObj)
                // 5.保存新的数组
                this.saveData(arr)
                this.setState({ textarea: '' })
            }
            handleChange = (event) =>{
                 this.setState({textarea: event.target.value});
            }
            render() {
                return (
                    <React.Fragment>
                        <h3>请留言</h3>
                        <p></p>
                        <p>海洋</p>
                        <h3>历史</h3>
                        <Text saveData={this.saveData} textBox={this.state.textBox} contId={this.state.contId} />
                        <hr />
                        <h3>发表评论</h3>
                        <textarea value={this.state.textarea} onChange={this.handleChange}  name="textarea" cols="30" rows="10"></textarea>
                        <button  onClick={this.addData}>发表评论</button>
                    </React.Fragment>
                )
            }

        }

        ReactDOM.render(
            <App />,
            document.getElementById('app')
        )
    </script>
</body>

</html>
