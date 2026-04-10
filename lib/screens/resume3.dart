import 'package:flutter/material.dart';

class ResumePage3 extends StatelessWidget {
  const ResumePage3({Key? key}) : super(key: key);

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

  static const Color tealColor = Color(0xFF4ECDC4);
  static const Color darkGray = Color(0xFF4A5568);
  static const Color lightGray = Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GABRIEL BAKER',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: darkGray,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Entry Level',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: tealColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 15),
          
          // Contact Info
          const Row(
            children: [
              ContactInfo(icon: Icons.phone, text: '+1-(234)-555-1234'),
              SizedBox(width: 20),
              ContactInfo(icon: Icons.email, text: 'info@resumementor.com'),
              SizedBox(width: 20),
              ContactInfo(icon: Icons.link, text: 'linkedin.com'),
              SizedBox(width: 20),
              ContactInfo(icon: Icons.location_on, text: 'Indianapolis, Indiana'),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Two Column Layout
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('PROFILE'),
                      const SizedBox(height: 12),
                      const Text(
                        'Enthusiastic software engineer with a Bachelor\'s degree and internship experience in software development and agile methodologies. Adept at developing software solutions and eager to contribute to advanced technological missions and team success.',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.6,
                          color: darkGray,
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      _buildSectionTitle('WORK HISTORY'),
                      const SizedBox(height: 15),
                      
                      _buildWorkExperience(
                        'Software Engineering Intern',
                        'Raytheon Technologies',
                        '05/2023 - 08/2023',
                        'Indianapolis, Indiana',
                        [
                          'Developed and tested software solutions with a team of engineers, contributing to a 15% increase in project efficiency.',
                          'Assisted in the design and implementation of new features for embedded systems, improving system performance by 20%.',
                          'Collaborated with senior engineers on debugging processes that reduced errors in the software by 30%.',
                          'Participated in Agile sprints and contributed to bi-weekly stand-ups, enhancing team collaboration and project timelines.',
                          'Documented software requirements and test cases which were used in three critical project phases.',
                          'Conducted research on artificial intelligence integration process resulting in a project proposal adopted for further development.',
                        ],
                      ),
                      
                      const SizedBox(height: 18),
                      
                      _buildWorkExperience(
                        'Junior Software Developer Intern',
                        'Northrop Grumman',
                        '01/2023 - 04/2023',
                        'Baltimore, Maryland',
                        [
                          'Assisted in the development of cloud-native applications, resulting in the deployment of two successful applications.',
                          'Contributed to team projects by conducting code reviews, leading to a 25% decrease in code defects.',
                          'Developed automated test scripts which increased testing efficiency by 40%.',
                          'Participated in Agile ceremonies and sprint planning improving overall project workflows and outcomes.',
                        ],
                      ),
                      
                      const SizedBox(height: 10),
                      
                     
                    ],
                  ),
                ),
                
                const SizedBox(width: 40),
                
                // Right Column
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('KEY ACHIEVEMENTS'),
                      const SizedBox(height: 12),
                      
                      _buildAchievement(
                        'Increased Project Efficiency',
                        'Developed software solutions that led to a 15% increase in team project efficiency.',
                      ),
                      
                      const SizedBox(height: 12),
                      
                      _buildAchievement(
                        'Error Reduction',
                        'Contributed to a debugging process that reduced software errors by 30%.',
                      ),
                      
                      const SizedBox(height: 12),
                      
                      _buildAchievement(
                        'Automated Testing',
                        'Developed automated test scripts, improving testing efficiency by 40%.',
                      ),
                      
                      const SizedBox(height: 12),
                      
                      _buildAchievement(
                        'Cloud Integration',
                        'Assisted in the development of two cloud-native applications successfully deployed.',
                      ),
                      
                      const SizedBox(height: 25),
                      
                      _buildSectionTitle('KEY SKILLS'),
                      const SizedBox(height: 12),
                      
                      const Text(
                        'Software Development, Agile Methodologies, Cloud Computing, Artificial Intelligence, Embedded Systems, Debugging',
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.6,
                          color: darkGray,
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      _buildSectionTitle('EDUCATION'),
                      const SizedBox(height: 12),
                      
                      _buildEducation(
                        'Bachelor\'s Degree in Software Engineering',
                        'Purdue University',
                        '01/2019 - 01/2023',
                        'West Lafayette, Indiana',
                      ),
                      
                      const SizedBox(height: 25),
                      
                      _buildSectionTitle('COURSES'),
                      const SizedBox(height: 12),
                      
                      _buildCourse(
                        'Certified Cloud Practitioner',
                        'AWS Training and Certification',
                      ),
                      
                      const SizedBox(height: 10),
                      
                      _buildCourse(
                        'Introduction to Machine Learning',
                        'Coursera by Stanford University',
                      ),
                      
                      const SizedBox(height: 10),
                      
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 2),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: darkGray,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildWorkExperience(
    String title,
    String company,
    String date,
    String location,
    List<String> points,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: darkGray,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                company,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: tealColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 10, color: lightGray),
            const SizedBox(width: 4),
            Text(
              date,
              style: const TextStyle(
                fontSize: 10,
                color: lightGray,
              ),
            ),
            const SizedBox(width: 15),
            const Icon(Icons.location_on, size: 10, color: lightGray),
            const SizedBox(width: 4),
            Text(
              location,
              style: const TextStyle(
                fontSize: 10,
                color: lightGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 11, color: darkGray)),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 10.5,
                        height: 1.5,
                        color: darkGray,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildVolunteerExperience(
    String title,
    String organization,
    String date,
    List<String> points,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: darkGray,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                organization,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: tealColor,
                ),
              ),
            ),
            const Icon(Icons.calendar_today, size: 10, color: lightGray),
            const SizedBox(width: 4),
            Text(
              date,
              style: const TextStyle(
                fontSize: 10,
                color: lightGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 11, color: darkGray)),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 10.5,
                        height: 1.5,
                        color: darkGray,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildAchievement(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: darkGray,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 10.5,
            height: 1.5,
            color: darkGray,
          ),
        ),
      ],
    );
  }

  Widget _buildEducation(String degree, String university, String date, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          degree,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: darkGray,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          university,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: tealColor,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 10, color: lightGray),
            const SizedBox(width: 4),
            Text(
              date,
              style: const TextStyle(
                fontSize: 10,
                color: lightGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.location_on, size: 10, color: lightGray),
            const SizedBox(width: 4),
            Text(
              location,
              style: const TextStyle(
                fontSize: 10,
                color: lightGray,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCourse(String title, String provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: tealColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          provider,
          style: const TextStyle(
            fontSize: 10.5,
            color: darkGray,
          ),
        ),
      ],
    );
  }

  Widget _buildPassion(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: darkGray,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 10.5,
            height: 1.5,
            color: darkGray,
          ),
        ),
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfo({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: ResumeContent.lightGray,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: ResumeContent.lightGray,
          ),
        ),
      ],
    );
  }
}