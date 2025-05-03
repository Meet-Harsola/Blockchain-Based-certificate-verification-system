pragma solidity ^0.8.0;

contract CertificateVerification {
    address public owner;
    
    struct Certificate {
        address issuer;
        string studentName;
        string courseName;
        string grade;
        uint256 issueDate;
        bool revoked;
    }
    
    // Maps certificateId (hash) => Certificate
    mapping(bytes32 => Certificate) public certificates;
    
    // Maps issuer address => bool (authorized or not)
    mapping(address => bool) public authorizedIssuers;
    
    // Events
    event CertificateIssued(bytes32 indexed certificateId, address indexed issuer, string studentName, string courseName);
    event CertificateRevoked(bytes32 indexed certificateId);
    event IssuerAuthorized(address indexed issuer);
    event IssuerRevoked(address indexed issuer);
    
    // Constructor
    constructor() {
        owner = msg.sender;
        authorizedIssuers[msg.sender] = true; // Owner is authorized by default
    }
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    modifier onlyAuthorizedIssuer() {
        require(authorizedIssuers[msg.sender], "Only authorized issuers can call this function");
        _;
    }
    
    // Owner functions
    function authorizeIssuer(address issuer) public onlyOwner {
        authorizedIssuers[issuer] = true;
        emit IssuerAuthorized(issuer);
    }
    
    function revokeIssuer(address issuer) public onlyOwner {
        require(issuer != owner, "Owner cannot be revoked");
        authorizedIssuers[issuer] = false;
        emit IssuerRevoked(issuer);
    }
    
    // Issuer functions
    function issueCertificate(
        string memory studentName,
        string memory studentId,
        string memory courseName,
        string memory grade
    ) public onlyAuthorizedIssuer returns (bytes32) {
        // Create a unique certificate ID by hashing several values
        bytes32 certificateId = keccak256(
            abi.encodePacked(
                msg.sender,
                studentName,
                studentId,
                courseName,
                grade,
                block.timestamp
            )
        );
        
        // Ensure this certificate ID doesn't exist already
        require(certificates[certificateId].issueDate == 0, "Certificate already exists");
        
        // Store certificate data
        certificates[certificateId] = Certificate({
            issuer: msg.sender,
            studentName: studentName,
            courseName: courseName,
            grade: grade,
            issueDate: block.timestamp,
            revoked: false
        });
        
        emit CertificateIssued(certificateId, msg.sender, studentName, courseName);
        
        return certificateId;
    }
    
    function revokeCertificate(bytes32 certificateId) public {
        Certificate storage cert = certificates[certificateId];
        
        // Only issuer or owner can revoke
        require(cert.issuer == msg.sender || msg.sender == owner, "Only issuer or owner can revoke");
        require(cert.issueDate > 0, "Certificate does not exist");
        require(!cert.revoked, "Certificate is already revoked");
        
        cert.revoked = true;
        
        emit CertificateRevoked(certificateId);
    }
    
    // Public verification functions
    function verifyCertificate(bytes32 certificateId) public view returns (
        address issuer,
        string memory studentName,
        string memory courseName,
        string memory grade,
        uint256 issueDate,
        bool isValid
    ) {
        Certificate memory cert = certificates[certificateId];
        
        require(cert.issueDate > 0, "Certificate does not exist");
        
        return (
            cert.issuer,
            cert.studentName,
            cert.courseName,
            cert.grade,
            cert.issueDate,
            !cert.revoked && authorizedIssuers[cert.issuer]
        );
    }
    
    function isCertificateValid(bytes32 certificateId) public view returns (bool) {
        Certificate memory cert = certificates[certificateId];
        return (cert.issueDate > 0 && !cert.revoked && authorizedIssuers[cert.issuer]);
    }
}