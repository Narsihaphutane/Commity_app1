import 'package:flutter/material.dart';

class ResumePage2 extends StatelessWidget {
  const ResumePage2({Key? key}) : super(key: key);

  static const Color backgroundColor = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        boundaryMargin: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 850),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 850,
                    height: 1100,
                    child: const ResumeContent(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ResumeContent extends StatelessWidget {
  const ResumeContent({Key? key}) : super(key: key);

  static const Color mintGreen = Color(0xFFB8DDD4);
  static const Color darkTeal = Color(0xFF2C5F5D);
  static const Color lightMint = Color(0xFFE8F3F1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Decorative mint green box on top left
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 160,
            height: 280,
            color: mintGreen,
          ),
        ),
        
        // Main Content
        Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          'ROBERT WIX',
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w800,
                            color: darkTeal,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Text(
                      'PROJECT MANAGER',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkTeal,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Summary
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: darkTeal, width: 2),
                  ),
                ),
                child: const Text(
                  'PMP-certified project manager with 8+ years of experience in the fashion industry. Keen to contribute to the success of the Your Style Clothing Inc. by establishing project milestones and collaborating closely with company stakeholders. Led a \$2.1-million project to successful completion within deadlines and with adherence to the budget in 2020-2021.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: darkTeal,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Contact Info Row
              Row(
                children: [
                  Expanded(
                    child: _buildContactItem('EMAIL', 'robert.wix@eeemail.com'),
                  ),
                  Expanded(
                    child: _buildContactItem('PHONE', '757-868-0025'),
                  ),
                  Expanded(
                    child: _buildContactItem('LINKEDIN', 'linkedin.com/in/robert.wix.172'),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Work History
              _buildSectionTitle('WORK HISTORY'),
              const SizedBox(height: 15),
              
              _buildTimelineItem(
                'Project Manager',
                'DEERSWEATER INC., MINNEAPOLIS,MN',
                '2018-05 - 2022-05',
                [
                  'Oversaw the design and marketing of 5 fashion collections.',
                  'Successfully prevented budget creep on a major project, saving \$10,000.',
                  'Modified and directed project plans to meet the needs of stakeholders without sacrificing key deliverables.',
                ],
                true,
              ),
              
              const SizedBox(height: 15),
              
              _buildTimelineItem(
                'Assistant Project Manager',
                'FASHIONOVO, LINCOLN, NE',
                '2016-04 - 2018-04',
                [
                  'Found and eliminated 70 inconsistencies in project documentation.',
                  'Documented project progress to fulfill project requirements and establish traceability.',
                  'Assisted in the implementation of a time tracking system that improved average team productivity by 9%.',
                ],
                false,
              ),
              
              const SizedBox(height: 30),
              
              // Education
              _buildSectionTitle('EDUCATION'),
              const SizedBox(height: 15),
              
              _buildEducationItem(
                'Management Studies, Master of Science',
                'KELLOG SCHOOL OF MANAGEMENT (NORTHWESTERN UNIVERSITY), EVANSTON, IL',
                '2017-09 - 2018-06',
                'GPA: 3.8',
                'Excelled in project management coursework',
              ),
              
              const SizedBox(height: 30),
              
              // Skills
              _buildSectionTitle('SKILLS'),
              const SizedBox(height: 12),
              
              Wrap(
                spacing: 30,
                runSpacing: 6,
                children: const [
                  SkillItem(text: 'Project planning and development'),
                  SkillItem(text: 'Advanced problem solving'),
                  SkillItem(text: 'Lean manufacturing and design'),
                  SkillItem(text: 'Six Sigma'),
                  SkillItem(text: 'Agile project management'),
                  SkillItem(text: 'Scrum'),
                  SkillItem(text: 'Budget management'),
                  SkillItem(text: 'Risk management'),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Volunteering
              _buildSectionTitle('VOLUNTEERING'),
              const SizedBox(height: 15),
              
              _buildVolunteerItem(
                'VOLUNTEER AT PROJECT MANAGERS AGAINST POVERTY (PMAP)',
                '2017-06 - PRESENT',
                [
                  'Coached 20 project managers at various NGOs worldwide as an e-mentor.',
                  'Consulted NGOs on 40 projects aimed at overcoming poverty and discrimination.',
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Certificates
              _buildSectionTitle('CERTIFICATES'),
              const SizedBox(height: 15),
              
              _buildCertificateItem(
                'Lean Six Sigma Black Belt™',
                'INTERNATIONAL ASSOCIATION FOR SIX SIGMA CERTIFICATION',
                '2021-10',
                true,
              ),
              
            
              
             
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: darkTeal,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildContactItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.w700,
            color: darkTeal,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 5,
            color: darkTeal,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String company,
    String date,
    List<String> points,
    bool isFirst,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: darkTeal,
                shape: BoxShape.circle,
              ),
            ),
            if (!isFirst)
              Container(
                width: 2,
                height: 80,
                color: darkTeal,
              ),
          ],
        ),
        const SizedBox(width: 15),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: darkTeal,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 9,
                      color: darkTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                company,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: darkTeal,
                ),
              ),
              const SizedBox(height: 8),
              ...points.map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 10, color: darkTeal)),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.4,
                              color: darkTeal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEducationItem(
    String degree,
    String institution,
    String date,
    String gpa,
    String note,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline marker
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: darkTeal,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 17),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      degree,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: darkTeal,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 9,
                      color: darkTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                institution,
                style: const TextStyle(
                  fontSize: 10,
                  color: darkTeal,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                gpa,
                style: const TextStyle(
                  fontSize: 10,
                  color: darkTeal,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                note,
                style: const TextStyle(
                  fontSize: 10,
                  color: darkTeal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVolunteerItem(String title, String date, List<String> points) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: darkTeal,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 17),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: darkTeal,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 9,
                      color: darkTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...points.map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 10, color: darkTeal)),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.4,
                              color: darkTeal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCertificateItem(
    String title,
    String organization,
    String date,
    bool isFirst,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: darkTeal,
                shape: BoxShape.circle,
              ),
            ),
            if (!isFirst)
              Container(
                width: 2,
                height: 40,
                color: darkTeal,
              ),
          ],
        ),
        const SizedBox(width: 17),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: darkTeal,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 9,
                      color: darkTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                organization,
                style: const TextStyle(
                  fontSize: 10,
                  color: darkTeal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SkillItem extends StatelessWidget {
  final String text;

  const SkillItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: ResumeContent.darkTeal,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: ResumeContent.darkTeal,
          ),
        ),
      ],
    );
  }
}