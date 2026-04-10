import 'package:flutter/material.dart';

class ResumePage4 extends StatelessWidget {
  const ResumePage4({Key? key}) : super(key: key);

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

  static const Color darkSidebar = Color(0xFF2D3748);
  static const Color accentColor = Color(0xFF4299E1);
  static const Color lightGray = Color(0xFFA0AEC0);
  static const Color darkText = Color(0xFF2D3748);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Sidebar
        Container(
          width: 280,
          color: darkSidebar,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=400&fit=crop',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // About Me
                _buildSidebarSection('ABOUT ME'),
                const SizedBox(height: 12),
                const Text(
                  'A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences.',
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.6,
                    color: Colors.white70,
                  ),
                ),
                
                const SizedBox(height: 25),
                
                // Education
                _buildSidebarSection('EDUCATION'),
                const SizedBox(height: 12),
                
                _buildEducationItem(
                  'MASTER IN GRAPHICS DESIGN',
                  'New York University',
                  '2014 - 2016',
                ),
                
                const SizedBox(height: 12),
                
                _buildEducationItem(
                  'BACHELOR OF SCIENCE IN GRAPHIC DESIGN',
                  'New York University',
                  '2010 - 2014',
                ),
                
                const SizedBox(height: 25),
                
                // Skills
                _buildSidebarSection('SKILLS'),
                const SizedBox(height: 12),
                
                _buildSkillBar('Photoshop', 0.95),
                const SizedBox(height: 10),
                _buildSkillBar('Illustrator', 0.90),
                const SizedBox(height: 10),
                _buildSkillBar('InDesign', 0.85),
                const SizedBox(height: 10),
                _buildSkillBar('CorelDraw', 0.80),
                const SizedBox(height: 10),
                _buildSkillBar('WordPress', 0.75),
                
                const SizedBox(height: 25),
                
                // Languages
                _buildSidebarSection('LANGUAGE'),
                const SizedBox(height: 12),
                
                _buildLanguageItem('English', 5),
                const SizedBox(height: 8),
                _buildLanguageItem('Spanish', 4),
                const SizedBox(height: 8),
                _buildLanguageItem('French', 3),
              ],
            ),
          ),
        ),
        
        // Right Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LORNA ALVARADO',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'GRAPHIC DESIGNER',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: lightGray,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Contact Info
                Row(
                  children: [
                    _buildContactItem(Icons.phone, '123-456-7890'),
                    const SizedBox(width: 20),
                    _buildContactItem(Icons.email, 'hello@reallygreatsite.com'),
                    const SizedBox(width: 20),
                    _buildContactItem(Icons.language, 'www.reallygreatsite.com'),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Experience Section
                _buildSectionTitle('EXPERIENCE'),
                const SizedBox(height: 15),
                
                _buildExperience(
                  'Lead Graphic Designer',
                  'Borcelle Studio',
                  '2018 - Present',
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae.',
                ),
                
                const SizedBox(height: 15),
                
                _buildExperience(
                  'Senior Graphic Designer',
                  'Studious',
                  '2016 - 2018',
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.',
                ),
                
                const SizedBox(height: 15),
                
                _buildExperience(
                  'Graphic Designer',
                  'Quisque Studio',
                  '2014 - 2016',
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.',
                ),
                
                const SizedBox(height: 15),
                
                _buildExperience(
                  'Marketing Manager',
                  'Fauget Company',
                  '2012 - 2014',
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.',
                ),
                
                const SizedBox(height: 30),
                
                // References
                _buildSectionTitle('REFERENCES'),
                const SizedBox(height: 15),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildReference(
                        'Estley Howard',
                        'Company Name / 123-456-7890',
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: _buildReference(
                        'Harper Brewer',
                        'Company Name / 123-456-7890',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarSection(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildEducationItem(String degree, String school, String years) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          degree,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          school,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          years,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillBar(String skill, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skill,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageItem(String language, int level) {
    return Row(
      children: [
        Expanded(
          child: Text(
            language,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: index < level ? accentColor : Colors.white24,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
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
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: darkText,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: lightGray,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: lightGray,
          ),
        ),
      ],
    );
  }

  Widget _buildExperience(
    String position,
    String company,
    String period,
    String description,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                position,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ),
            Text(
              period,
              style: const TextStyle(
                fontSize: 10,
                color: lightGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          company,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: accentColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 10.5,
            height: 1.6,
            color: darkText,
          ),
        ),
      ],
    );
  }

  Widget _buildReference(String name, String details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          details,
          style: const TextStyle(
            fontSize: 10,
            color: lightGray,
          ),
        ),
      ],
    );
  }
}